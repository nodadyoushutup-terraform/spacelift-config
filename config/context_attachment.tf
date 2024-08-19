# context_attachment.tf

resource "spacelift_context_attachment" "context_attachment_debug" {
  for_each = data.spacelift_stacks.stacks
  context_id = "debug"
  stack_id   = each.value.stack_id
  priority   = 0
}