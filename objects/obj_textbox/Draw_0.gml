/// @description draw text
accept_key = keyboard_check_pressed(vk_space);

textbox_x = camera_get_view_x(view_camera[0])
textbox_y = camera_get_view_y(view_camera[0]) + 144;

//setup

if setup == false{

setup = true;
draw_set_font(fnt_dialogue);
draw_set_color(c_black);
draw_set_valign(fa_top);
draw_set_halign(fa_left);

//loop through the papers
page_number = array_length(text);
for(var p = 0; p < page_number; p++){

//find how many characters are on each page & store
//that number in the text_length array
text_length[p] = string_length(text[p]);

// get x position for txtboxx
// no character center txtbox
text_x_offset[p] = 44;

}
}

//typing the text

if draw_char < text_length[page]{
draw_char += text_spd;
draw_char = clamp(draw_char, 0, text_length[page]);

}


// Flip through the pages
if accept_key {
    // If typing is done, go to the next page
    if draw_char == text_length[page] {
        // Next page
        if page < page_number - 1 {
            page++;
            draw_char = 0;
        }
        // If there are no more pages, destroy the textbox
        else {
            instance_destroy();
        }
    }
    // If typing is not done, finish typing the current page
    else {
        draw_char = text_length[page];
    }
}


//draw the textbox
txtb_img += txtb_img_spd;
txtb_spr_w = sprite_get_width(txtb_spr);
txtb_spr_h = sprite_get_height(txtb_spr);

//back of textbox
draw_sprite_ext(txtb_spr, txtb_img, textbox_x + text_x_offset[page], textbox_y, textbox_width / txtb_spr_w, textbox_height / txtb_spr_h,0, c_white,1);

//draw the text
var _drawtext = string_copy(text[page],1 , draw_char);
draw_text_ext(textbox_x + text_x_offset[page] + border, textbox_y + border, _drawtext, line_sep, line_width);
