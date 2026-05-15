#!/bin/sh
# Single source of truth for the void/cool theme.
# Edit values here, then run:  make theme   (or  ./scripts/apply-theme.sh )

# --- Backgrounds ----------------------------------------------------------
THEME_BG="#08090E"          # main background
THEME_BG_DARK="#060810"     # darker (sidebar, inactive)
THEME_BG_FLOAT="#0E1018"    # floats, popups, statusline
THEME_BG_HIGHLIGHT="#141620" # cursorline, subtle selection
THEME_BG_SELECT="#1F2335"   # visual selection, marked

# --- Foregrounds ----------------------------------------------------------
THEME_FG="#D8DCE8"          # default text
THEME_FG_DARK="#B8BCC8"     # secondary text
THEME_COMMENT="#5A5F78"     # comments, inactive borders
THEME_GUTTER="#50546A"      # line numbers, hints

# --- Syntax accents (cool palette) ---------------------------------------
THEME_BLUE="#7AA2F7"        # keywords (return, export, function)
THEME_CYAN="#7DCFFF"        # types, JSX components, active borders
THEME_TEAL="#73DACA"        # methods, properties
THEME_MAGENTA="#C7A1FF"     # tags, decorators
THEME_PURPLE="#BB9AF7"      # numbers, booleans, constants
THEME_STRING="#9DC8FF"      # strings (cool, not warm green)
THEME_VARIABLE="#E0CCFF"    # variables, parameters
THEME_NUMBER="#A9C5FF"      # literals
THEME_RED="#F38BA8"         # errors, deletions

# Export so child processes (envsubst, etc.) can see them.
export THEME_BG THEME_BG_DARK THEME_BG_FLOAT THEME_BG_HIGHLIGHT THEME_BG_SELECT
export THEME_FG THEME_FG_DARK THEME_COMMENT THEME_GUTTER
export THEME_BLUE THEME_CYAN THEME_TEAL THEME_MAGENTA THEME_PURPLE
export THEME_STRING THEME_VARIABLE THEME_NUMBER THEME_RED
