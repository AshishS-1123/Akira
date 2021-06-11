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
 * Authored by: Alessandro "Alecaddd" Castellani <castellani.ale@gmail.com>
 */

/**
 * Fill component to keep track of a single filling, which includes different attributes.
 */
public class Akira.Lib.Components.Fill : Component {
    public unowned Fills fills { get; set; }
    // Since items can have multiple filling colors, we need to keep track of each
    // with a unique identifier in order to properly update them.
    public int id { get; set; }

    public Gdk.RGBA color { get; set; }

    // Store the hexadecimal string version of the color (E.g.: #FF00CC)
    public string hex { get; set; }
    public int alpha { get; set; }
    public bool hidden { get; set; }

    // color mode determines the type of color we use.
    // possible values are 'simple', 'linear', 'radial'
    public string color_mode { get; set; }
    // the gradient object will be responsible for storing stop colors and drawing the gradient
    public Gradient gradient;

    // store current color so when reverting back to 'simple' mode, it can be used
    private Gdk.RGBA prev_color;

    // this signal is triggered when the color mode changes
    public signal void on_mode_change ();

    public Fill (Fills _fills, Items.CanvasItem _item, Gdk.RGBA init_color, int fill_id) {
        fills = _fills;
        item = _item;
        id = fill_id;
        color = init_color;
        hex = color.to_string ();
        alpha = 255;
        prev_color = init_color;

        color_mode = "simple";
        gradient = new Gradient (_item);

        // Listen for changed to the fill attributes to properly trigger the color generation.
        this.notify["color"].connect (() => {
            // check if gradient is present
            if (gradient.is_enabled ())
            return;

            hex = Utils.Color.rgba_to_hex (color.to_string ());
            fills.reload ();
            // on color change, remember this color
            prev_color = color;
        });

        this.notify["hidden"].connect (() => {
            fills.reload ();
        });

        // listen for changes in color mode
        on_mode_change.connect (()=> {

            if (color_mode == "simple") {
                color = prev_color;
                hex = Utils.Color.rgba_to_hex (color.to_string ());
                alpha = (int) (color.alpha * 255);
                gradient.disable ();
                fills.reload ();
            }
            else {
                gradient.set_gradient_type (color_mode);

                gradient.enable ();
                gradient.draw_direction_line ();
                gradient.draw_gradient ();
            }
        });

    }

    public void remove () {
        fills.remove_fill (this);
    }
}
