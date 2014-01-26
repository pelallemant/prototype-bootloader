extern void scrollup(unsigned int);
extern void print(char *);

extern kY;
extern kattr;

void _start()
{
 scrollup(25);

  kY = 0;
	kattr = 0x4E;
	print("The kernel has started\n");

  while(1);
}
