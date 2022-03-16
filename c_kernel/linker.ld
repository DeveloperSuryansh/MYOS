ENTRY(start)

SECTIONS
{
	/* we need 1MB of space atleast */
	. = 1000;

  	/* text section */
	.text BLOCK(4K) : ALIGN(4K)
	{
		*(.multiboot)
		*(.text)
	}
}