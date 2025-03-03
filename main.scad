$fn = 70;

cross_thickness = 1.3;
cross_length = 4.0 + 0.2;

axis_thickness = 1.0;
axis_diameter = 6.2;

axis_depth = 6.0;
thickness = 1;
top_r = 0.6;
cap_width = 18.0;
cap_height = cap_width;
cap_depth = 9;

module fillet2d(r, d = 0)
{
    offset(r = r) offset(delta = -r) children(0);
}

module axis_base()
{
    difference()
    {
        circle(r = axis_diameter / 2);

        translate([ 0, axis_thickness ])
        {
            square(size = [ cross_thickness, cross_length + axis_thickness ], center = true);
        }
        square(size = [ cross_length, cross_thickness ], center = true);
    }
}

module axis()
{
    linear_extrude(height = axis_depth + thickness) axis_base();
}

module top_base(d = 0)
{
    fillet2d(r = top_r, d = d)
    {
        square(size = [ cap_width, cap_height ], center = true);
    }
}

module outer()
{
    difference()
    {
        linear_extrude(height = cap_depth)
        {
            fillet2d(r = top_r)
            {
                square(size = [ cap_width, cap_height ], center = true);
            }
        }

        translate([ 0, 0, thickness ])
        {
            linear_extrude(height = cap_depth)
            {
                fillet2d(r = top_r, d = thickness)
                {
                    square(size = [ cap_width - thickness * 2, cap_height - thickness * 2 ], center = true);
                }
            }
        }
    }
}

axis();
outer();
