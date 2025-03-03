$fn = 70;

cross_thickness = 1.4;
cross_length = 4.0 + 0.2;

axis_diameter = 6.0;

axis_depth = 6.0;
thickness = 1;
top_r = 0.6;
cap_width = 18.0;
cap_height = cap_width;
cap_depth = 9;

character = "";

function top_thickness() = (character == "") ? thickness : thickness * 2;

module fillet2d(r, d = 0)
{
    offset(r = r) offset(delta = -r) children(0);
}

module axis_base()
{
    difference()
    {
        circle(r = axis_diameter / 2);

        {
            square(size = [ cross_thickness, cross_length ], center = true);
            square(size = [ cross_length, cross_thickness ], center = true);
            translate([ 0, cross_length / 2 ])
            {
                square(size = [ cross_thickness, cross_length ], center = true);
            }
        }
    }
}

module axis()
{
    linear_extrude(height = axis_depth + top_thickness()) axis_base();
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

        translate([ 0, 0, top_thickness() ])
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

module character_top()
{
    linear_extrude(height = thickness * 2, center = true)
    {
        scale([ 0.8, 0.8 ])
        {
            mirror([ 1, 0 ])
            {
                text(text = character, size = cap_width, valign = "center", halign = "center");
            }
        }
    }
}

difference()
{
    union()
    {
        axis();
        outer();
    }

    if (character != "")
    {
        character_top();
    }
}
