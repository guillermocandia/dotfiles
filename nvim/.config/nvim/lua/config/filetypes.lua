vim.filetype.add({
  pattern = {
    [".*/%.xsessionrc"] = "sh",
    [".*/%.xsession"] = "sh",
  },
  filename = {
    ["ContainerFile"] = "dockerfile"
  }  
})
