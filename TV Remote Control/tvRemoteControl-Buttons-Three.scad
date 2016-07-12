use <tvRemoteControl-Buttons.scad>;


module three()
{
    button(0,0);
    button(0,4);
    button(0,8);

    hull() {
        base(0,0);
        base(0,8);
    }
}


three();

