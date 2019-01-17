#!/bin/bash

#####################################################
# 14.2 look into the module sources                 #
#####################################################
# which functions are supported by the driver ?
# static int scull_open(struct inode *inode, struct file *filp);
# static int scull_release(struct inode *inode, struct file *filp);
# static ssize_t scull_read(struct file *filp, char __user *buf, size_t count, loff_t *f_pos);
# static ssize_t scull_write(struct file *filp, const char __user *buf, size_t count, loff_t *f_pos);

# where does the system get to know about 
# the supported functions?
# static struct file_operations fops = {
#	.open = scull_open,
#	.release = scull_release,
#	.write = scull_write,
#	.read = scull_read
# };

# how and where is the memory for the device created ?
# in the function
# static int __init scull_init(void)
# with kmalloc():
# scull_dev[i].array = (char *) kmalloc(scull_size * sizeof(char), GFP_KERNEL)

# how and where is the memory for the device released ?
# in the exit function:
# static void __exit scull_exit(void)
# with kfree():
# kfree(scull_dev[i].array);

# which function is used to print messages into the log file ?
# printk():
# example: printk("Exiting %s\n", NAME);

# why is it not possible to read the same data twice from the device ?
# after reading the count is substracted from the position:
# *f_pos -= count;

# how is this type of reading called ?
# consuming read

# how is it avoided that the module is beeing unloaded while it is in use ?
# while in use the device is registered with the function
# try_module_get() which increments the used by count of the
# kernel module. try_module_put() decrements this counter.
# while this counter is not zero the module can't be removed.

# in which mode is the module running ? in system- or usermode ?
# since it is running in the kernel-space -> system mode.