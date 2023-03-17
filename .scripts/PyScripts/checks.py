import shutil
import psutil

def check_disk_usage(disk="/"):
    du = shutils.disk_usage(disk)
    free = du.free / du.total * 100
    return free > 20

