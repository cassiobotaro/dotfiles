# Barra de abas no estilo do Terminal do GNOME (Ptyxis): abas de largura
# igual ocupando a largura toda, título centralizado e a aba ativa numa
# "pílula" arredondada. Carregado pelo kitty.conf (tab_bar_style custom) a
# partir de ~/.config/kitty/tab_bar.py.
import os

from kitty.boss import get_boss
from kitty.fast_data_types import Screen, add_timer, wcswidth
from kitty.tab_bar import DrawData, ExtraData, TabBarData, as_rgb
from kitty.utils import color_as_int

LEFT_CAP = '\ue0b6'   # meia-lua esquerda (powerline arredondado)
RIGHT_CAP = '\ue0b4'  # meia-lua direita
GAP = 1               # espaço entre abas
REFRESH = 1.0         # segundos entre redesenhos (detecta comando novo)

# mesma ideia do ptyxis_is_shell(): esses não entram no título
SHELLS = frozenset({
    'sh', 'bash', 'zsh', 'fish', 'dash', 'ash', 'ksh', 'tcsh', 'csh',
    'nu', 'xonsh', 'elvish', 'pwsh', 'login',
})


def _title(tab: TabBarData) -> str:
    """Igual ao ptyxis_tab_dup_title(): título OSC do programa ou "Terminal",
    mais " — <comando>" se o processo em primeiro plano não for um shell."""
    title = tab.title
    try:
        t = get_boss().tab_for_id(tab.tab_id)
        w = t.active_window if t else None
    except Exception:
        w = None
    if w is None:
        return title or 'Terminal'
    if not w.override_title and (not w.child_title or w.child_title == w.default_title):
        # nenhum programa definiu título (o kitty usa o nome do shell)
        title = 'Terminal'
    try:
        cmd = w.child.foreground_cmdline
    except Exception:
        cmd = []
    if cmd and os.path.basename(cmd[0]).lstrip('-') not in SHELLS:
        title += ' — ' + ' '.join(cmd)
    return title


def _redraw(timer_id: int | None) -> None:
    # o kitty só redesenha a barra quando o título muda; o comando em
    # primeiro plano pode mudar sem isso, então redesenha periodicamente
    for tm in get_boss().all_tab_managers:
        tm.mark_tab_bar_dirty()


_timer: int | None = None


def _fit(title: str, width: int) -> str:
    if wcswidth(title) <= width:
        return title
    out = ''
    for ch in title:
        if wcswidth(out + ch) > width - 1:
            break
        out += ch
    return out + '…'


def draw_tab(
    draw_data: DrawData, screen: Screen, tab: TabBarData,
    before: int, max_tab_length: int, index: int, is_last: bool,
    extra_data: ExtraData,
) -> int:
    # Desenhar sempre exatamente max_tab_length faz o layout do kitty dividir
    # a largura igualmente entre as abas.
    global _timer
    if _timer is None:
        _timer = add_timer(_redraw, REFRESH, True)
    gap = 0 if is_last else GAP
    width = max(1, max_tab_length - gap)
    bar_bg = as_rgb(color_as_int(draw_data.default_bg))
    tab_bg = as_rgb(draw_data.tab_bg(tab))
    tab_fg = as_rgb(draw_data.tab_fg(tab))

    caps = tab.is_active and width >= 4
    inner = width - 2 if caps else width
    title = _fit(_title(tab), max(1, inner - 2))
    pad = inner - wcswidth(title)
    left, right = pad // 2, pad - pad // 2

    if caps:
        screen.cursor.fg, screen.cursor.bg = tab_bg, bar_bg
        screen.draw(LEFT_CAP)
    screen.cursor.fg, screen.cursor.bg = tab_fg, tab_bg
    screen.draw(' ' * left + title + ' ' * right)
    if caps:
        screen.cursor.fg, screen.cursor.bg = tab_bg, bar_bg
        screen.draw(RIGHT_CAP)
    if gap:
        screen.cursor.bg = bar_bg
        screen.draw(' ' * gap)
    return screen.cursor.x
