
/**
 * Copyright (c) 2022 Alecaddd (https://alecaddd.com)
 *
 * This file is part of Akira.
 *
 * Akira is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.

 * Akira is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.

 * You should have received a copy of the GNU General Public License
 * along with Akira. If not, see <https://www.gnu.org/licenses/>.
 *
 * Authored by: Ashish Shevale <shevaleashish@gmail.com>
 */

/*
 * This widget provides a set of options that allow user to select what kind of pattern
 * they want to draw.
 * Selecting ony one of the buttons will change the pattern type (SOLID, LINEAR, RADIAL).
 */
public class Akira.Widgets.PatternChooser : Granite.Widgets.ModeButton {
    // Trigger this signal when the active PatternType changes or gradient editor changes.
    public signal void pattern_changed (Lib.Components.Pattern pattern);

    construct {
        construct_chooser_widget ();
    }

    private void construct_chooser_widget () {
        this.append_text ("Solid");
        this.append_text ("Linear");
        this.append_text ("Radial");
    }
}
