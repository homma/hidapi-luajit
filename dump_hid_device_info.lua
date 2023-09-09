local ffi = require 'ffi'

local wchar_to_string = function(str)
  local wchar_size = ffi.sizeof 'wchar_t'
  local len = ffi.C.wcslen(str)
  local buf = ffi.new('char[?]', len * wchar_size)
  ffi.C.wcstombs(buf, str, len)

  return ffi.string(buf)
end

local print_dev = function(dev)
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

local main = function()
  -- initialize ffi
  local f = io.open('hidapi.cdef', 'r')
  local cdefs = f:read 'a'
  ffi.cdef(cdefs)

  local hidapi = ffi.load 'hidapi'

  -- additional libc function
  ffi.cdef [[
    size_t wcstombs(char * dest, const wchar_t * src, size_t n);
  ]]

  -- initialize hidapi
  local ref = hidapi.hid_init()
  hidapi.hid_darwin_set_open_exclusive(0)

  -- look up hid devices
  local dev = hidapi.hid_enumerate(0, 0)

  while true do
    print_dev(dev)

    if dev.next == nil then
      break
    else
      dev = dev.next
    end
  end
end

main()
