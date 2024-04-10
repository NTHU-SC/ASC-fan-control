# -*- coding: utf-8 -*-
# time: 2023/12/06 15:36
# file: fan.py
# 公众号: 玩转测试开发
import re
import requests
import warnings
from concurrent.futures import ThreadPoolExecutor
from multiprocessing import Pool
import sys

warnings.filterwarnings("ignore")


class Fans(object):
    headers = {
        "content-type": "application/json",
        "User-Agent": r"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36 Edg/117.0.2045.60",
    }

    def __init__(self, host, username, password):
        self.host = host
        self.username = username
        self.password = password

    def get_random(self):
        url = f"https://{self.host}/api/randomtag"
        res = requests.get(url, headers=self.headers, verify=False)
        return res.json()["random"]

    def get_session(self, random_string):
        url = f"https://{self.host}/api/session"
        self.headers["content-type"] = "application/x-www-form-urlencoded; charset=UTF-8"
        data = {
            "encrypt_flag": 0,
            "username": self.username,
            "password": self.password,
            "login_tag": str(random_string)
        }
        response = requests.post(url, headers=self.headers, data=data, verify=False)
        token = re.findall("QSESSIONID=(.*?);", response.headers["Set-Cookie"])[0]
        self.headers["X-Csrftoken"] = response.json()["CSRFToken"]

        self.headers["Cookie"] = str("lang=zh-cn;QSESSIONID=" + token + "; refresh_disable=1")
        self.headers["content-type"] = "application/json"

    def get_fans(self):
        url = f"https://{self.host}/api/status/fan_info"
        response = requests.get(url, headers=self.headers, verify=False).json()
        for k, v in response.items():
            if k == "fans":
                for i in v:
                    print(i)

    def fans_mode(self, mode="manual"):
        url = f"https://{self.host}/api/settings/fans-mode"
        # manual - auto
        data = {"control_mode": mode}
        response = requests.put(url, headers=self.headers, json=data, verify=False)
        print("response:", response.text)

    def _change_single_fan(self, i, rate):
        url = f'https://{self.host}/api/settings/fan/{i}'
        data = {"duty": rate}
        response = requests.put(url=url, json=data, verify=False, headers=self.headers)
        response.encoding = "utf-8"
        print(f"The index {i} fan change to {response.json()['duty']} %", )

    def change_fans(self, rate=100, fans=24):
        with ThreadPoolExecutor(max_workers=fans) as executor:
            futures = [executor.submit(self._change_single_fan, i, rate) for i in range(fans)]
            for future in futures:
                future.result()

def manage_fans_for_host(bmc_host, rate):
    print(rate)
    username = "admin"
    password = "admin"
    f = Fans(host=bmc_host, username=username, password=password)
    random_string = f.get_random()  # Make sure get_random is adapted to work in a synchronous context
    f.get_session(random_string)  # Ensure get_session is adapted to work in a synchronous context
    f.get_fans()  # Ensure get_fans is adapted to work in a synchronous context
    if rate == "auto":
        f.fans_mode("auto")  # Ensure fans_mode is adapted to work in a synchronous context
    else:
        f.fans_mode("manual")
        f.change_fans(rate=int(rate), fans=12)  # Ensure change_fans is adapted to work in a synchronous context

if __name__ == '__main__':
    if len(sys.argv) != 2:
        print("Usage: python script.py <rate or 'auto'>")
        sys.exit(1)

    rate = sys.argv[1]
    print(rate)
    bmc_hosts = ["10.123.64.21", "10.123.64.22", "10.123.64.23", "10.123.64.24"]
    
    # Prepare a list of tuples where each tuple is a set of arguments for manage_fans_for_host
    args_for_processes = [(host, rate) for host in bmc_hosts]
    
    with Pool() as pool:
        pool.starmap(manage_fans_for_host, args_for_processes)