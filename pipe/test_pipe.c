#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main() {
  printf("starting C program!\n");

  char buffer[100];
  ssize_t bytesRead = read(STDIN_FILENO, buffer, sizeof(buffer));

  if (bytesRead < 0) {
    perror("Error reading from pipe");
    return 1;
  }

  printf("C Program received: %.*s\n", (int)bytesRead, buffer);

  return 0;
}
