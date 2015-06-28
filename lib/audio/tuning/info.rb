require 'audio/octave_range'

module Audio
  module Tuning
    class Info
      def initialize(
        pitch, 
        tuningType, 
        rootSound, 
        transpositionNote, 
        octaveRange = OctaveRange.new(1, 3)
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
