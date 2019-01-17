/****************************************************/
/* SCULL Version für den 2.6er Kernel               */
/* Geaendert durch Korbinian Hammer                 */
/* Aenderung: 17.1.14, L. Frank                     */
/* English translation and adaption to kernel 4.15: */
/* Pascal Zimmermann, 2018-12-04                    */
/****************************************************/

/////////////////////////////////////////////////////////////////////////////////////////////////////////

#include <linux/module.h>
#include <linux/init.h>
#include <linux/fs.h>
#include <linux/uaccess.h>
#include <asm/string.h>
#include <linux/slab.h>

/////////////////////////////////////////////////////////////////////////////////////////////////////////

#define NAME "scull"
#define MAX_DEVICES 2

/////////////////////////////////////////////////////////////////////////////////////////////////////////

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Korbinian Hammer");
MODULE_DESCRIPTION("Scull v. 2");
MODULE_SUPPORTED_DEVICE("none");

/////////////////////////////////////////////////////////////////////////////////////////////////////////

static int scull_open(struct inode *inode, struct file *filp);
static int scull_release(struct inode *inode, struct file *filp);
static ssize_t scull_read(struct file *filp, char __user *buf, size_t count, loff_t *f_pos);
static ssize_t scull_write(struct file *filp, const char __user *buf, size_t count, loff_t *f_pos);

/////////////////////////////////////////////////////////////////////////////////////////////////////////

unsigned int scull_size = 1000;

module_param(scull_size, int, 0);

static int majorNumber;

/////////////////////////////////////////////////////////////////////////////////////////////////////////

static struct file_operations fops = {
	.open = scull_open,
	.release = scull_release,
	.write = scull_write,
	.read = scull_read
};

/////////////////////////////////////////////////////////////////////////////////////////////////////////

typedef struct scull
{
	char *array;
	int position;
}scull;

scull scull_dev[MAX_DEVICES];

/////////////////////////////////////////////////////////////////////////////////////////////////////////

// scull_open
static int scull_open(struct inode *inode, struct file *filp)
{
	int minor;
	try_module_get(THIS_MODULE);
	
	minor = MINOR(inode->i_rdev);

	if((minor < 0) || (minor >= MAX_DEVICES))
	{
		printk("Unknown device!\n");
		return -ENODEV;
	}
	
	printk("Opening of %s\n", NAME);

	if(!filp)
	{
		printk("Error at accessing filp!");
		return -ENODEV;
	}

	filp->private_data = &scull_dev[minor];

	return 0;
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////


// scull_releas
static int scull_release(struct inode *inode, struct file *filp)
{
	printk("Closing of %s\n", NAME);	

	module_put(THIS_MODULE);

	return 0;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////


// scull_read
static ssize_t scull_read(struct file *filp, char __user *buf, size_t count, loff_t *f_pos)
{
	scull *dev;
	
	printk("Reading of %s\n", NAME);

	if(!filp)
	{
		printk("Error at accessing filp!");
		return -ENODEV;
	}

	dev = (scull *) filp->private_data;

	if(count > dev->position)
	{
		count = dev->position;
	}

	if(copy_to_user(buf, dev->array,count) != 0)
	{
		printk("Error at copy_to_user\n");
		return -EFAULT;
	}
	
	*f_pos -= count;

	dev->position -= count;

	filp->private_data = dev;

	return count;
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////


// scull_write
static ssize_t scull_write(struct file *filp, const char __user *buf, size_t count, loff_t *f_pos)
{
	scull *dev;
	
	printk("Writing of %s\n", NAME);

	if(!filp)
	{
		printk("Error at accessing flip!");
		return -ENODEV;
	}

	dev = (scull *) filp->private_data;

	if(count + dev->position >= scull_size)
	{
		count = scull_size - dev->position;
		if(!count)
		{
			printk("%s is full!\n", NAME);
			return -ENOMEM;
		}
	}

	if(copy_from_user(dev->array + dev->position, buf, count) != 0)
	{
		printk("Error at copy_from_user!\n");
		return -EFAULT;
	}

	*f_pos += count;
	dev->position += count;
	filp->private_data = dev;

	return count;
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////


// scull_init
static int __init scull_init(void)
{
	int i , e;

	//SET_MODULE_OWNER(&fops);

	printk("Initializing %s\n", NAME);
	printk("Size of scull_size: %i\n", scull_size);

	majorNumber = register_chrdev(0,NAME,&fops);

	if(majorNumber < 0)
	{
		printk(KERN_WARNING "%s: Device could not be registered!\n", NAME);
		return majorNumber;
	}

	printk("Major number: %d\n", majorNumber);

	for(i = 0; i < MAX_DEVICES; i++)
	{
		if(!(scull_dev[i].array = (char *) kmalloc(scull_size * sizeof(char), GFP_KERNEL)))
		{
			printk("Could not allocate space");

			for(e = 0; e < i; ++e)
			{
				kfree(scull_dev[i].array);
			}
			unregister_chrdev(majorNumber,NAME);
			return -EFAULT;
		}

		scull_dev[i].position = 0;	
	}

	return 0;
	
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////

// scull_exit
static void __exit scull_exit(void)
{
	int i;

	printk("Exiting %s\n", NAME);
	
	for(i = 0; i < MAX_DEVICES; i++)
	{
		kfree(scull_dev[i].array);
	}

	unregister_chrdev(majorNumber,NAME);
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////

module_init(scull_init);
module_exit(scull_exit);

/////////////////////////////////////////////////////////////////////////////////////////////////////////
