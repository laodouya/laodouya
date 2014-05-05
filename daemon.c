#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<fcntl.h>
#include<signal.h>
#include<sys/types.h>
#include<unistd.h>
#include<sys/wait.h>
#include <sys/stat.h>
#define MAXFILE 65535
void sigterm_handler(int arg);
volatile sig_atomic_t _running = 1;
int main()
{
    pid_t pc,pid;
    int i,len;
    pc = fork(); //第一步
    if(pc<0){
        printf("error fork\n");
        exit(1);
    }
    else if(pc>0)
        exit(0);  //kill father
    
    pid = setsid(); //第二步
    if (pid < 0)
        perror("setsid error");

    pc = fork(); //第三步
    if(pc<0){
        printf("error fork\n");
        exit(1);
    }
    else if(pc>0)
        exit(0);  //kill father
    
    for(i=0;i<MAXFILE;i++) //第四步
        close(i);
 
    chdir("/"); //第五步
    umask(0); //第六步
    
    signal(SIGCHLD,SIG_IGN); //第七步
    
    signal(SIGTERM, sigterm_handler); //第八步
    
    while( _running )
    {
        //TODO Your thing.
        sleep(100);
    }
    
    return 0;
}
void sigterm_handler(int arg)
{
    _running = 0;
}
