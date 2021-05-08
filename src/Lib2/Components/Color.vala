/**
 * Copyright (c) 2019-2021 Alecaddd (https://alecaddd.com)
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
 * Authored by: Martin "mbfraga" Fraga <mbfraga@gmail.com>
 */

public class Akira.Lib2.Components.Color : Object {

    // Or to a given value
    private Gdk.RGBA _color;
    private int _alpha;
    private bool _hidden;

    public Gdk.RGBA color {
        get {
            return _color;
        }
    }

    public int alpha {
        get {
            return _alpha;
        }
    }

    public bool hidden {
        get {
            return _hidden;
        }
    }

    public Color (Gdk.RGBA new_color, int alpha, bool hidden) {
        _color = new_color;
        _alpha = alpha;
        _hidden = hidden;
    }

    public Color with_color (Gdk.RGBA new_color) {
        return new Color (new_color, _alpha, _hidden);
    }

    public Color with_alpha (int new_alpha) {
        return new Color (_color, new_alpha, _hidden);
    }

    public Color with_hidden (bool new_hidden) {
        return new Color (_color, _alpha, new_hidden);
    }
}
