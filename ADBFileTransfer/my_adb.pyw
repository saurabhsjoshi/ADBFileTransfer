from adb import ADB
import sys
import os


def checkIfFile(a,b):
    for m in a.splitlines():
        if(m.strip() == (b + '/').strip()):
            return False
    return True
        
def main(argc, argv):
    if argc > 0:
        adb = ADB(os.path.dirname(os.path.abspath(__file__)) + "/adb")
        if argv[1] == "0":
            adb.start_server();
            print adb.get_version()
            
        elif argv[1] == "1":
            path = argv[2]
            a = adb.shell_command("\"cd " + path +  " && ls -d */\"")
            b = adb.shell_command("ls " + path)
            print a
            print "INTERNALEND"
            for s in b.splitlines():
                if(checkIfFile(a,s)):
                    print s
        else:
            print "Wrong Argument"
    else:
        print "wtf"

if __name__ == "__main__":
    main(len(sys.argv) - 1, sys.argv)
