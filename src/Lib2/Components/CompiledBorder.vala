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

public class Akira.Lib2.Components.CompiledBorder : Object {
    private Gdk.RGBA _color;
    private int _size;

    public Gdk.RGBA color {
        get { return _color; }
    }

    public int size {
        get { return _size; }
    }

    public CompiledBorder (Gdk.RGBA color, int size) {
        _color = color;
        _size = size;
    }

    public static CompiledBorder compile (Borders? borders, Opacity? opacity) {

        var rgba_border = Gdk.RGBA ();
        bool has_colors = false;
        int size = 0;

        // Set an initial arbitrary color with full transparency.
        rgba_border.alpha = 0;

        if (borders == null) {
            return new CompiledBorder(rgba_border, size);
        }

        // Loop through all the configured borders and reload the color.
        foreach (var border in borders.borders) {
            // Skip if the border is hidden as we don't need to blend colors.
            if (border.color.hidden) {
                continue;
            }

            // Set the new blended color.
            rgba_border = Utils.Color.blend_colors (rgba_border, border.color.color);
            size = int.max (size, border.size);
            has_colors = true;
        }

        // Apply the mixed RGBA value only if we had one.
        if (has_colors && opacity != null) {
            // Keep in consideration the global opacity to properly update the border color.
            rgba_border.alpha = rgba_border.alpha * opacity.opacity / 100;
        }

        return new CompiledBorder(rgba_border, size);
    }
}
