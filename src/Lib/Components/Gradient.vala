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
 * Authored by: Ashish Shevale <shevaleashish@gmail.com>
 */

 public class Akira.Lib.Components.Gradient: Component {
    // toggle this when shifting to or from simple color to gradient
    private bool gradient_enabled;
    private bool is_linear_type;// true for linear gradient and false for radial gradient

    // these are coordinates of direction line
    private double start_x;
    private double start_y;
    private double end_x;
    private double end_y;

    // pattern(gradient) to be displayed
    private Cairo.Pattern gradient_pattern;
    // list of stop colors according to their position
    private Gee.ArrayList<Gdk.RGBA?> stop_colors;

    public Gradient (Items.CanvasItem _item) {
        item = _item;

        // initially, the gradient is not present, as default mode is simple color
        gradient_enabled = false;

        is_linear_type = true;

        Gdk.RGBA color = Gdk.RGBA ();
        stop_colors = new Gee.ArrayList<Gdk.RGBA?> ();

        color.parse ("rgba(255,255,255,255)");
        stop_colors.add ( color );

        color.parse ("rgba(0,0,0,1)");
        stop_colors.add ( color );
    }

    public void draw_direction_line () {

        // these values are the default positions of the direction line.
        // when the user drags the line around, these values will change,
        // thus updating the gradient
        item.get ("x", out start_x);
        item.get ("y", out start_y);

        item.get ("width", out end_x);
        item.get ("height", out end_y);

        end_x += start_x;
        end_y += start_y;

        // TODO: Draw a line using Cairo that user can move around to change the gradient direction
    }

    public void draw_gradient () {
        if (!gradient_enabled) {
            return;
        }

        // create a new pattern
        if (is_linear_type) {
            gradient_pattern = new Cairo.Pattern.linear (start_x, start_y, end_x, end_y);
        }
        else {
            // the radius of outer circle in radial gradient equals the length of direction line.
            double diff_x = start_x - end_x;
            double diff_y = start_y - end_y;
            int radius = (int)Math.sqrt ( diff_x * diff_x + diff_y * diff_y );

            gradient_pattern = new Cairo.Pattern.radial (start_x, start_y, 0, start_x, start_y, radius);
        }

        // add the colors
        for (int location = 0; location < stop_colors.size; ++location) {
            double red = stop_colors[location].red;
            double green = stop_colors[location].green;
            double blue = stop_colors[location].blue;
            double alpha = stop_colors[location].alpha;

            gradient_pattern.add_color_stop_rgba (location, red, green, blue, alpha);
        }

        // assign this gradient to the canvas item
        item.fill_pattern = gradient_pattern;
    }

    public void enable () {
        gradient_enabled = true;
    }

    public bool is_enabled () {
        return gradient_enabled;
    }

    public void disable () {
        gradient_enabled = false;

        item.fill_pattern = null;
    }

    public void set_gradient_type (string type) {
        if (type == "linear") {
            is_linear_type = true;
        }
        else {
            is_linear_type = false;
        }
    }

}
