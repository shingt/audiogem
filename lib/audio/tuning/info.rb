require 'audio/octave_range'

module Audio
  module Tuning
    class Info
      DEFAULT_OCTAVE_FIRST = 1
      DEFAULT_OCTAVE_LAST  = 4

      def initialize(
        pitch, 
        tuningType, 
        rootSound, 
        transpositionNote, 
        octaveRange = OctaveRange.new(DEFAULT_OCTAVE_FIRST, DEFAULT_OCTAVE_LAST)
      )
        @pitch             = pitch
        @tuningType        = tuningType
        @rootSound         = rootSound
        @transpositionNote = transpositionNote
        @octaveRange       = octaveRange
      end
      attr_accessor :pitch, :tuningType, :rootSound, :transpositionNote, :octaveRange
    end
  end
end
