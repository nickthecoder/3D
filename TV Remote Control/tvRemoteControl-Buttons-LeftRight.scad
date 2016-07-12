use <tvRemoteControl-Buttons.scad>;


module leftRight()
{    
    button(5,-3) rotate(180) arrow();
    button(10,-3) arrow();
    
    hull() {
        base(5,-3);
        base(10,-3);
    }
}

leftRight();
