#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

int main() {
  const char *pipeName = "my_pipe";

  // Open the named pipe for reading
  int fd = open(pipeName, O_RDONLY);
  if (fd == -1) {
    perror("Error opening named pipe for reading");
    return 1;
  }

  // Read data from the named pipe
  char buffer[100];
  ssize_t bytesRead = read(fd, buffer, sizeof(buffer));
  if (bytesRead == -1) {
    perror("Error reading from named pipe");
    close(fd);
    return 1;
  }

  // Print the received data
  printf("Data read from the named pipe: %.*s\n", (int)bytesRead, buffer);

  // Close the named pipe
  close(fd);

  return 0;
}
