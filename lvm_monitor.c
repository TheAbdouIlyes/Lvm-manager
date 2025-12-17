#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#define LOGFILE "/var/log/lvm_monitor.log"

int main(int argc, char *argv[]) {
    if (argc < 2) {
        printf("Usage: %s <threshold>\n", argv[0]);
        return 1;
    }

    int threshold = atoi(argv[1]);
    const char *mounts[] = {"/mnt/data1", "/mnt/data2", "/mnt/data3"};

    for (int i = 0; i < 3; i++) {
        char cmd[512];
        snprintf(cmd, sizeof(cmd),
                 "df %s | awk 'NR==2 {print $5}'",
                 mounts[i]);

        FILE *fp = popen(cmd, "r");
        if (!fp) continue;

        char buf[32];
        fgets(buf, sizeof(buf), fp);
        pclose(fp);

        int used = atoi(buf);
        if (used >= threshold) {
            snprintf(cmd, sizeof(cmd),
                     "/usr/local/bin/lvm_manager $(df %s | awk 'NR==2 {print $1}') %s %d >> %s 2>&1",
                     mounts[i], mounts[i], threshold, LOGFILE);
            system(cmd);
        }
    }
    return 0;
}

