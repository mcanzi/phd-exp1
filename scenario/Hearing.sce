#-- scenario header --#

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
	sound {wavefile { filename="bubapu.wav"; }; description = "10";} my_second;
	sound {wavefile { filename="dipida.wav"; }; description = "11";};
} second;

array {
	sound {wavefile { filename="dabapu.wav"; }; description = "12";} my_wrong;
	sound {wavefile { filename="dobapu.wav"; }; description = "13";};
	sound {wavefile { filename="bapida.wav"; }; description = "14";};
	sound {wavefile { filename="bupida.wav"; }; description = "15";};
} wrong;

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
	trial_duration = 1000;
	picture {
		text {
			caption = "";
			font_size = 48; } debug_text;
		x = 0; y = 0; };
	time = 0; } debug_trial;


begin_pcl;

int count1 = 0;
int count2 = 0;
int count3 = 0;
int wrongCounter = 0;

loop int c = 1 until c > 1 begin # block grouping
	loop int b = 1 until b > 5 begin # 5 bigger blocks
 		loop int a = 1 until a > 15 begin # 2 smaller blocks
    		first.shuffle();
			loop int i = 1 until i > first.count() begin # loop through array

      			string code = first[i].description();
      			int pair = int(code);

      			event1.set_stimulus( first[i] );
      			event1.set_event_code( code );
					int td = random(1600,1800);
					first_trial.set_duration ( td );
      			first_trial.present();

     				if pair == 1 then
						count1 = random(1,3);

						if count1 < 3 then
							event2.set_stimulus( second[1] );
							event2.set_event_code( code );
							event2.set_port_code( 10 );
							second_trial.present();
						elseif count1 == 3 then
							wrongCounter = random(1,2);
							if wrongCounter == 1 then
								event2.set_stimulus( wrong[1] );
								event2.set_event_code( code + "WRONG1" );
								event2.set_port_code( 12 );
								second_trial.present();
							elseif wrongCounter == 2 then
								event2.set_stimulus( wrong[2] );
								event2.set_event_code( code + "WRONG2" );
								event2.set_port_code( 13 );
								second_trial.present();
							end;
						end;

      			elseif pair == 2 then
						count2 = random(1,3);
						if count2 < 3 then
							event2.set_stimulus( second[2] );
							event2.set_event_code( code );
							event2.set_port_code( 11 );
							second_trial.present();
						elseif count2 == 3 then
							wrongCounter = random(1,2);
							if wrongCounter == 1 then
								event2.set_stimulus( wrong[3] );
								event2.set_event_code( code + "WRONG1" );
								event2.set_port_code( 14 );
								second_trial.present();
							elseif wrongCounter == 2 then
								event2.set_stimulus( wrong[4] );
								event2.set_event_code( code + "WRONG2" );
								event2.set_port_code( 15 );
								second_trial.present();
							end;
						end;
      			end;
				i = i + 1; # array loop counter
			end;
			a = a + 1; # smaller block counter
		end;
		if b < 2 then
    		break_trial.present();
		end;
		b = b + 1; # bigger block counter
	end;
	c = c + 1; # counter for block grouping
	longer_break.present();
end
