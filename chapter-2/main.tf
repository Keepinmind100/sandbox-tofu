resource "local_file" "hello" {
    filename = "${path.module}/hello.txt"
    content  = "Hello, World!"
    file_permission = "0644"
}