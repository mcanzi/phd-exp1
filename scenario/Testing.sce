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
	trial_duration = forever;
	trial_type = first_response;
	all_responses = false;
	picture {
		text { caption = "+"; font_size = 36; };
	x = 0; y = 0; };
	stimulus_event {
		sound my_second;
		time = 0;
		stimulus_time_in = 500;
		target_button = 1;
		response_active = true;
	} event2;
} second_trial;

trial {
	trial_duration = 1000;
	picture {
		text {
			caption = "correct";
			font_size = 48;
			font_color = 0,255,0; };
		x = 0; y = 0; };
	time = 0; } righto;

trial {
	trial_duration = 1000;
	picture {
		text {
			caption = "incorrect";
			font_size = 48;
			font_color = 255,0,0; };
		x = 0; y = 0; };
	time = 0; } wrongo;

trial {
	trial_duration = 10000;
	picture {
		text {
			caption = "";
			font_size = 48; } final_result;
		x = 0; y = 0; };
	time = 0; } final_score;

begin_pcl;

int count1 = 0;
int count2 = 0;
int count3 = 0;
int count = 0;
int total = 0;
int repeat = 0;
int countCorrect = 0;
int wrongCounter = 0;

loop repeat until repeat == 1 begin
	loop int a = 1 until a > 8 begin
		first.shuffle();
		loop int i = 1 until i > first.count() begin
			if countCorrect < 5 then
				string code = first[i].description();
				int pair = int(code);

				event1.set_stimulus( first[i] );
				event1.set_event_code( code );
				int td = random(1600,1800);
				first_trial.set_duration( td );
				first_trial.present();

				if pair == 1 then
					count1 = random(1,3);
					if count1 < 3 then
						event2.set_stimulus( second[1] );
						event2.set_event_code( code );
						event2.set_port_code( 10 );
						event2.set_target_button( 1 );
						second_trial.present();
						stimulus_data last = stimulus_manager.last_stimulus_data();

						if last.type() == stimulus_hit then
							righto.present();
							count - count + 1;
							total = total + 1;
							countCorrect = countCorrect + 1;
						else
							wrongo.present();
							total = total + 1;
							countCorrect = 0;
						end;
					elseif count1 == 3 then
						wrongCounter = random(1,2);
						if wrongCounter == 1 then
							event2.set_stimulus( wrong[1] );
							event2.set_event_code( code + "WRONG1" );
							event2.set_port_code( 12 );
						elseif wrongCounter == 2 then
							event2.set_stimulus( wrong[2] );
							event2.set_event_code( code + "WRONG2" );
							event2.set_port_code( 13 );
						end;
						event2.set_target_button( 2 );
						second_trial.present();
						stimulus_data last = stimulus_manager.last_stimulus_data();

						if last.type() == stimulus_hit then
							righto.present();
							count = count + 1;
							total = total + 1;
							countCorrect = countCorrect + 1;
						else
							wrongo.present();
							total = total + 1;
							countCorrect = 0;
						end;
					end;
				elseif pair == 2 then
					count2 = random(1,3);

					if count2 < 3 then
						event2.set_stimulus( second[2] );
						event2.set_event_code( code );
						event2.set_port_code( 11 );
						event2.set_target_button( 1 );
						second_trial.present();
						stimulus_data last = stimulus_manager.last_stimulus_data();

						if last.type() == stimulus_hit then
							righto.present();
							count = count + 1;
							total = total + 1;
							countCorrect = countCorrect + 1;
						else
							wrongo.present();
							total = total + 1;
							countCorrect = 0;
						end;

					elseif count2 == 3 then
						wrongCounter = random(1,2);
						if wrongCounter == 1 then
							event2.set_stimulus( wrong[3] );
							event2.set_event_code( code + "WRONG1" );
							event2.set_port_code( 14 );
						elseif wrongCounter == 2 then
							event2.set_stimulus( wrong[4] );
							event2.set_event_code( code + "WRONG2" );
							event2.set_port_code( 15 );
						end;
						event2.set_target_button( 2 );
						second_trial.present();
						stimulus_data last = stimulus_manager.last_stimulus_data();

						if last.type() == stimulus_hit then
							righto.present();
							count = count + 1;
							total = total + 1;
							countCorrect = countCorrect + 1;
						else
							wrongo.present();
							total = total + 1;
							countCorrect = 0;
						end;
					end;
				end;
			elseif countCorrect == 5 then
				final_result.set_caption( "Congratulations\n You passed the test!" );
				final_result.set_font_color(0,255,0);
				final_result.set_font_size(36);
				final_result.redraw();
				final_score.present();
				break;
			end;
		i = i + 1;
		end;
	a = a + 1;
	end;
final_result.set_caption("Training starts again");
final_result.set_font_color(255,0,0);
final_result.set_font_size(36);
final_result.redraw();
final_score.present();
end;
