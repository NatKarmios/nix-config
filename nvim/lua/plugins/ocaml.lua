-- OCaml
return {
  'tarides/ocaml.nvim',
  config = function()
    require('ocaml').setup {
      keymaps = {
        jump_next_hole = '<localleader>hn',
        jump_prev_hole = '<localleader>hp',
        construct = '<localleader>c',
        jump = '<localleader>j',
        phrase_prev = '<localleader>p',
        phrase_next = '<localleader>n',
        infer = '<localleader>i',
        switch_ml_mli = '<localleader>s',
        type_enclosing = '<localleader>t',
        type_enclosing_grow = '<Up>',
        type_enclosing_shrink = '<Down>',
        type_enclosing_increase = '<Right>',
        type_enclosing_decrease = '<Left>',
      },
    }
  end,
}
