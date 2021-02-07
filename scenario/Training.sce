#-- scenario header --#

# THIS SCENARIO REQUIRES NO EEG DATA COLLECTION

response_matching = simple_matching;
default_font_size = 48;
active_buttons = 2;
button_codes = 1,2;
write_codes = true;

#-- SDL part --#

begin;

array {
	sound {wavefile { filename="piputu.wav"; }; description = "1";} my_first;
	sound {wavefile { filename="tapabi.wav"; }; description = "2";};
} first;

array {
	sound {wavefile { filename="bubapu.wav"; }; description = "1";} my_second;
	sound {wavefile { filename="dipida.wav"; }; description = "2";};
} second;

trial {
 trial_duration = 1600;
 trial_type = first_response;
 all_responses = false;
picture {
  text { caption = "+"; font_size = 36; };
x = 0; y = 0; };
 stimulus_event {
    sound my_first;
  time = 0;
    response_active = true;
 } event1;
} first_trial;

trial {
 trial_duration = 2700;
 trial_type = first_response;
 all_responses = false;
picture {
  text { caption = "+"; font_size = 36; };
x = 0; y = 0; };
 stimulus_event {
    sound my_second;
  time = 0;
    response_active = true;
 } event2;
} second_trial;

trial {
trial_type = first_response;
trial_duration = forever;
picture {
  text { caption = "Time for a longer break"; font_size = 48; };
x = 0; y = 0; } break_pic;
} longer_break;

trial {
trial_duration = 30000;
stimulus_event {
  picture {
    text { caption = "Take a break";
      font_size = 48; };
    x = 0; y = 0; };
    time = 0; duration = 20000; } break;
stimulus_event {
  picture {
    text { caption = "Experiment commencing soon";
      font_size = 48; };
    x = 0; y = 0; };
    time = 20000; duration = 7000; } break2;
  stimulus_event {
  picture {
    text { caption = "Starting...";
      font_size = 48; };
    x = 0; y = 0; };
    time = 27000; duration = 3000; } break3;
} break_trial;

trial {
  trial_duration = 5000;
  picture {
    text {
      caption = "lol";
      font_size = 48; } code_text;
    x = 0; y = 0; } code_picture;
  time = 0; } code_trial;

#-- PCL part --#

begin_pcl;

# BEGIN 1
loop int c = 1 until c > 5 begin # block grouping
	# BEGIN 2
	loop int b = 1 until b > 5 begin # 5 bigger blocks
 		# begin 3
 		loop int a = 1 until a > 5 begin # 2 smaller blocks
    		first.shuffle();
			#BEGIN 4
			loop int i = 1 until i > first.count() begin # loop through array

      			string code = first[i].description();
      			int pair = int(code);

      			event1.set_stimulus( first[i] );
      			event1.set_event_code( code );
      			first_trial.present();

     				#BEGIN 5
     				if pair == 1 then
        				event2.set_stimulus( second[1] );
        				event2.set_event_code( code );
        				event2.set_port_code( 13 );
        				second_trial.present();
      				elseif pair == 2 then
        				event2.set_stimulus( second[2] );
        				event2.set_event_code( code );
        				event2.set_port_code( 14 );
        				second_trial.present();
      			end;

			i = i + 1; # array loop counter
    			#END 4
			end;

		a = a + 1; # smaller block counter
		#END 3
		end;
	#BEGIN 3
	if b < 5 then
    		break_trial.present();
	#END 3
 	end;
	b = b + 1; # bigger block counter
	#END2
	end;

c = c + 1; # counter for block grouping
longer_break.present();
#END 1
end
