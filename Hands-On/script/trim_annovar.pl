#!/usr/bin/perl
use strict;
use warnings;

# Reduce ANNOVAR effects to the one with the most impact
my $file = shift;
open (my $fh, '<', $file) or die "Can't open $file. $!";

my %terms = (
  'exon_variant;synonymous_variant'    => 'synonymous_variant',
  'exon_variant;missense_variant'      => 'missense_variant',
  'exon_variant;sequence_variant'      => 'exon_variant',
  'exon_variant;stop_gained'           => 'stop_gained',
  'exon_variant;frameshift_truncation' => 'frameshift_truncation',
  'exon_variant;inframe_deletion'      => 'inframe_deletion',
  'exon_variant;inframe_insertion'     => 'inframe_insertion',
  'exon_variant;frameshift_elongation' => 'frameshift_elongation',
  'exon_variant;stop_lost'             => 'stop_lost',
  'exonic_splice_region_variant;missense_variant' => 'exonic_splice_region_variant', 
  'exonic_splice_region_variant;synonymous_variant' => 'exonic_splice_region_variant', 
  'non_coding_transcript_exon_variant;splice_region_variant' => 'splice_region_variant',
  'exon_variant;synonymous_variant;missense_variant' => 'missense_variant',
  'exon_variant;frameshift_variant;frameshift_elongation' => 'frameshift_elongation',
  'exon_variant;stop_gained;synonymous_variant' => 'stop_gained', 
  'exon_variant;inframe_insertion;inframe_variant' => 'inframe_insertion',
  'exon_variant;inframe_insertion;frameshift_elongation' => 'frameshift_elongation',
  'synonymous_variant;missense_variant' => 'missense_variant',
  'stop_gained;synonymous_variant' => 'stop_gained',
  'inframe_insertion;frameshift_elongation' => 'frameshift_elongation',
);

while (<$fh>) {

  chomp $_;
  my ($chr, $start, $end, $ids, $ann, $tool) = split('\t', $_);
  if (($ann eq '.') || ($ann !~ /;/)) {
    print "$_\n";
    next;
  }
  else {
    if (exists $terms{$ann}) {
      $ann = $terms{$ann};
      print "$chr\t$start\t$end\t$ids\t$ann\t$tool\n";
    }
    else {
      print "Can't map term $ann\n";
    }
  }

}
close $fh;
