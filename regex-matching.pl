#!usr/bin/perl
use warnings;
use strict;
use Gtk2 -init;
use constant TRUE =>1;
use Constant FALSE=>0;

my $window = Gtk2::Window->new("toplevel");
	$window->signal_connect(delete_event=> sub{Gtk2->main_quit});	
	$window->set_title("Regex Matching Program.");
	$window->set_border_width(4);
	$window->set_default_size(400, 300);
my $vbox = Gtk2::VBox->new();
	my $frame2 = Gtk2::Frame->new();
		$frame2->set_border_width(5);
		$frame2->set_label("Text Entry");
	my $textbuffer = Gtk2::TextBuffer->new();
	my $textview = Gtk2::TextView->new();
		$textview->set_buffer($textbuffer);
		$textview->set_editable(1);
		$textview->set_wrap_mode("char");
	$frame2->add($textview);
	my $frame3=Gtk2::Frame->new();
		$frame3->set_border_width(5);
		$frame3->set_label("Matched Character.");
		my $output = Gtk2::Entry->new();
			$output->set_editable(1);
		$frame3->add($output);
	my $table = Gtk2::Table->new( 1, 2, 2);
	my $frame = Gtk2::Frame->new();
		$frame->set_border_width(5);
		$frame->set_label("Regex Entry");
		my $regex = Gtk2::Entry->new();
			$regex->set_text("Regexes go here!");
			$regex->set_editable(1);
		my $evalbutton = Gtk2::Button->new();
			$evalbutton->set_label("Match");
			$evalbutton->signal_connect(clicked => sub{
				$output->set_text("");
				my $inputtext;
				my $regexinput;
				my $startiter = $textbuffer->get_start_iter;
				my $enditer = $textbuffer->get_end_iter;
				$inputtext = $textbuffer->get_text($startiter, $enditer, 1);
				$regexinput = $regex->get_text;
				my @texttomatch = $inputtext;
				print "@texttomatch\n";
				print "$regexinput\n";
				my @found = grep{$_ =~ /\w*$regexinput\w*/} @texttomatch;
				$output->append_text(@texttomatch);
				}
			);
		$table->attach($regex, 0, 9, 0, 1, 'fill', 'fill', 0, 0);
		$table->attach($evalbutton, 0, 1, 1, 3, 'shrink', 'shrink', 0, 0);
	$frame->add($table);
$vbox->add($frame2);
$vbox->add($frame);
$vbox->add($frame3);
$window->add($vbox);
$window->show_all;
Gtk2->main;