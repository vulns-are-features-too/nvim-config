aug FirenvimGroup
    au!
    let g:firenvim_config = {
        \ 'globalSettings': {
            \ 'alt': 'all',
        \    },
        \ 'localSettings': {
            \ '.*': {
                \ 'cmdline': 'neovim',
                \ 'priority': 0,
                \ 'selector': 'textarea',
                \ 'takeover': 'never',
            \ },
        \ }
    \ }
    let fc = g:firenvim_config['localSettings']
    " Change font size in firenvim
    fu! s:IsFirenvimActive(event) abort
        if !exists('*nvim_get_chan_info')
            return 0
        endif
        let l:ui = nvim_get_chan_info(a:event.chan)
        return has_key(l:ui, 'client') && has_key(l:ui.client, 'name') &&
                \ l:ui.client.name =~? 'Firenvim'
    endf
    fu! OnFirenvimEnter(event) abort
        if s:IsFirenvimActive(a:event)
            set guifont=*:h12
        endif
    endf
    au UIEnter * call OnFirenvimEnter(deepcopy(v:event))
    au BufEnter github.com_*.txt set filetype=markdown
aug end
