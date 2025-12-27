-- Super powered motion!

local function as_ft(key_specific_args, is_f)
  local common_args = {
    inputlen = 1,
    inclusive = true,
    -- To limit search scope to the current line:
    -- pattern = function (pat) return '\\%.l'..pat end,
    opts = {
      labels = '',  -- force autojump
      safe_labels = vim.fn.mode(1):match'[no]' and '' or nil,
    },
  }
  return vim.tbl_deep_extend('keep', common_args, key_specific_args)
end

local function clever_f()
  return require('leap.user').with_traversal_keys('f', 'F')
end
local function clever_t()
  return require('leap.user').with_traversal_keys('t', 'T')
end

return {
  url = 'https://codeberg.org/andyg/leap.nvim.git',
  keys = {
    { ',', '<Plug>(leap)', mode = {'n', 'x', 'o', 'v'} },
    { 'g,', '<Plug>(leap)' },
    {
      'f',
      function()
        require('leap').leap(as_ft({ opts = clever_f() }))
      end
    },
    {
      'F',
      function()
        require('leap').leap(as_ft({ backward = true, opts = clever_f() }))
      end,
    },
    {
      't',
      function()
        require('leap').leap(as_ft({ offset = -1, opts = clever_t() }))
      end,
    },
    {
      'T',
      function()
        require('leap').leap(as_ft({ backward = true, offset = 1, opts = clever_t() }))
      end,
    },
  },
}

