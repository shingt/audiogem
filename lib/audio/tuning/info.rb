module Audio
  module Tuning
    class Info
      def initialize(pitch, tuningType, rootSound, transpositionNote)
#        super

        @pitch = pitch
        @tuningType = tuningType
        @rootSound = rootSound
        @transpositionNote = transpositionNote
      end
      
      attr_accessor :pitch, :tuningType, :rootSound, :transpositionNote
    end
  end
end
