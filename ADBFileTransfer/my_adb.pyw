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

        #Testing
        if argv[1] == "0":
            adb.start_server();
            print adb.get_version()

        #Get file list
        elif argv[1] == "1":
            path = argv[2]
            a = adb.shell_command("\"cd " + path +  " && ls -ad */\"")
            if "*/" not in a:
                print a
            print "INTERNALEND"
            b = adb.shell_command("\"ls " + path + "\"")
            try:
                for s in b.splitlines():
                    if(checkIfFile(a,s)):
                        print s
            except:
                "INTERNALNODIR"

        #Get file/folder size
        elif argv[1] == "2":
            file_args = argv[2:]
            for single in file_args:
                b = adb.shell_command("\"du -ks " + single + "\"")
                print b.split("\t")[0]
        else:
            print "Wrong Argument"
    else:
        print "wtf"
    quit()

if __name__ == "__main__":
    main(len(sys.argv) - 1, sys.argv)
