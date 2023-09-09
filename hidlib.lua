local ffi = require 'ffi'

local M = {}

local init_c = function()
  -- additional libc function
  ffi.cdef [[
    size_t wcstombs(char * dest, const wchar_t * src, size_t n);
  ]]
end

local init_module = function()
  init_c()
end

local wchar_to_string = function(str)
  local wchar_size = ffi.sizeof 'wchar_t'
  local len = ffi.C.wcslen(str)
  local buf = ffi.new('char[?]', len * wchar_size)
  ffi.C.wcstombs(buf, str, len)

  return ffi.string(buf)
end

M.print_hid_device_info = function(dev)
  print '\n== DEVICE =='
  print('path                 ' .. ffi.string(dev.path))
  print('vendor_id            ' .. dev.vendor_id)
  print('product_id           ' .. dev.product_id)
  print('serial_number        ' .. wchar_to_string(dev.serial_number))
  print('release_number       ' .. dev.release_number)
  print('manufacturer_string  ' .. wchar_to_string(dev.manufacturer_string))
  print('product_string       ' .. wchar_to_string(dev.product_string))
  print('usage_page           ' .. dev.usage_page)
  print('usage                ' .. dev.usage)
  print('interface_number     ' .. dev.interface_number)
end

init_module()

return M
