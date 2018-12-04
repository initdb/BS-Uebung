

counting_process:
	gcc -o counting_process counting_process.c

counting_process_sem:
	gcc -o counting_process_sem counting_process_sem.c

counting_process_flock: 
	gcc -o counting_process_flock counting_process_flock.c

.PHONY: all	clean

all: counting_process	counting_process_sem	counting_process_flock

clean:
	rm counting_process
	rm counting_process_sem
	rm counting_process_flock