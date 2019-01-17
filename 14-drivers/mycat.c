/**********************************/
/* mycat - ein cat fuer den scull */
/* Erstellt von Korbinian Hammer  */
/**********************************/

#include <stdio.h>
#define MAX 8182

int main(int argc, char* argv[]) {

	char buffer[MAX];
	FILE *fp;
	int count;
	int i;

	if(argc != 2) {

		printf("Usage: mycat <file>\n<file> has to be ONE arguement!\n");	
	
		return 1;

	}
	else {

		fp = fopen(argv[1], "r");

		if(fp != NULL) {

			count = fread(buffer, sizeof(char), MAX, fp);

			for(i = 0; i < count; i++) {
				printf("%c", buffer[i]);
			}
		
			fclose(fp);
	
			return 0;

		}
		else {
			printf("Can't open File!\n");

			return 1;
		}
	}
}
