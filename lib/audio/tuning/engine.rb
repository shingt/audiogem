require 'audio/sound'
require 'logger'

module Audio 
  module Tuning
    class Engine 

      DEFAULT_MAX_OCTAVE = 6

      def self.tuneByInfo(info)  
        tuning = nil

        case info.tuningType 
        when "equal"
          tuning = self.tuneEqualByInfo(info)
        when "pureMajor"
          tuning = self.tunePureMajorByInfo(info)
        when "pureMinor"
          tuning = self.tunePureMinorByInfo(info)
        when "pythagorean"
          Logger.log("Not yet supported. Abort.")
        else
          Logger.log("Unexpected tuning type: #{info.tuningType}. Abort.")
          return nil
        end

        Logger.log("Pitch: #{info.pitch}")

        return tuning
      end

      private

      def self.frequencyForPitch(pitch, order) 
        return pitch * (2.0 ** (order / 12.0))
      end

      # Refer to: http:#ja.wikipedia.org/wiki/%E9%9F%B3%E5%90%8D%E3%83%BB%E9%9A%8E%E5%90%8D%E8%A1%A8%E8%A8%98
      # BASE_C means C1
      def self.tuneEqualBase(pitch, transpositionNote) 

        # Based on the case in which transposition is "C"
        baseTuning = [
          self.frequencyForPitch(pitch, 3.0)  / 16.0,  # Cのkey
          self.frequencyForPitch(pitch, 4.0)  / 16.0,  # Db
          self.frequencyForPitch(pitch, 5.0)  / 16.0,  # D
          self.frequencyForPitch(pitch, 6.0)  / 16.0,  # Eb
          self.frequencyForPitch(pitch, 7.0)  / 16.0,  # E
          self.frequencyForPitch(pitch, 8.0)  / 16.0,  # F
          self.frequencyForPitch(pitch, 9.0)  / 16.0,  # Gb
          self.frequencyForPitch(pitch, 10.0) / 16.0,  # G
          self.frequencyForPitch(pitch, 11.0) / 16.0,  # Ab
          self.frequencyForPitch(pitch, 0.0)  / 8.0,  # A
          self.frequencyForPitch(pitch, 1.0)  / 8.0,  # Bb
          self.frequencyForPitch(pitch, 2.0)  / 8.0,  # B
        ]

        sounds = [
          SOUND_BASE_C, SOUND_BASE_Db, SOUND_BASE_D, SOUND_BASE_Eb, SOUND_BASE_E, SOUND_BASE_F,
          SOUND_BASE_Gb, SOUND_BASE_G, SOUND_BASE_Ab, SOUND_BASE_A, SOUND_BASE_Bb, SOUND_BASE_B
        ].freeze

        rearrangedBaseTuning = []

        for i in 0...sounds.count do
          if transpositionNote == sounds[i] then
            for j in baseTuning[i...baseTuning.count] do
              rearrangedBaseTuning.push(j)
            end
            for j in baseTuning[0...i] do
              rearrangedBaseTuning.push(j)
            end
            break
          end
          baseTuning[i] *= 2.0
        end

        # FIXME: Go up until Gb and go down after that
        indexBoundary = 6  # index of Gb
        indexOfTranspositionNote = sounds.index(transpositionNote)
        if (indexBoundary < indexOfTranspositionNote) then
          for i in 0...rearrangedBaseTuning.count do
            rearrangedBaseTuning[i] /= 2.0
          end
        end

        tuning = {}
        for i in 0...sounds.count do
          tuning[sounds[i]] = rearrangedBaseTuning[i]
        end
        return tuning
      end

      # Integral multiplication for 12 tuningBase sounds for each octave 
      def self.tuneForOctave(octave, tuningBase)
        tuningForCurrentOctave = {}
        for key in tuningBase.keys do
          keyForCurrentOctave = key.to_s + octave.to_s
          frequencyForCurrentOctave = 2.0 ** (octave - 1) * tuningBase[key] 
          tuningForCurrentOctave[keyForCurrentOctave] = frequencyForCurrentOctave
        end
        return tuningForCurrentOctave
      end

      # Tuning Equal
      def self.transposeTuningBase(tuningBase, transpositionNote)
        return tuningBase
      end

      def self.tuneEqualByInfo(tuningInfo)
        tuning = {}
        tuningBase = self.tuneEqualBase(tuningInfo.pitch, tuningInfo.transpositionNote)

        for octave in 1...DEFAULT_MAX_OCTAVE do
          tuningForThisOctave = self.tuneForOctave(octave, tuningBase)
          for (soundName, frequency) in tuningForThisOctave do
            tuning[soundName] = frequency
          end
        end
        return tuning
      end

      # Tuning Pure Major
      # Frequency ratio to base pitch: r = 2^(n/12 + m/1200)
      # n: num of sound intervals (1 for semitone.)  
      # m: offset to Equal Pitch(cent)
      def self.centOffsetsForPureMajor
        offset1  =   0.0 / 1200.0
        offset2  = -29.3 / 1200.0
        offset3  =   3.9 / 1200.0
        offset4  =  15.6 / 1200.0
        offset5  = -13.7 / 1200.0
        offset6  =  -2.0 / 1200.0
        offset7  = -31.3 / 1200.0
        offset8  =   2.0 / 1200.0
        offset9  = -27.4 / 1200.0
        offset10 = -15.6 / 1200.0
        offset11 =  17.6 / 1200.0
        offset12 = -11.7 / 1200.0
        return [offset1, offset2, offset3, offset4, offset5, offset6, offset7, offset8, offset9, offset10, offset11, offset12]
      end

      # Tuning Pure Minor
      # Frequency ratio to base pitch: r = 2^(n/12 + m/1200)
      # n: num of sound intervals (1 for semitone.)  
      # m: offset to Equal Pitch(cent)
      def self.centOffsetsForPureMinor 
        offset1  =   0.0 / 1200.0
        offset2  =  33.2 / 1200.0
        offset3  =   3.9 / 1200.0
        offset4  =  15.6 / 1200.0
        offset5  = -13.7 / 1200.0
        offset6  =  -2.0 / 1200.0
        offset7  =  31.3 / 1200.0
        offset8  =   2.0 / 1200.0
        offset9  =  13.7 / 1200.0
        offset10 = -15.6 / 1200.0
        offset11 =  17.6 / 1200.0
        offset12 = -11.7 / 1200.0
        return [offset1, offset2, offset3, offset4, offset5, offset6, offset7, offset8, offset9, offset10, offset11, offset12]
      end

      # Generates sounds array based on assigned root sound
      def self.arrangeSoundNamesForRootSound(rootSound) 
        soundNames = [
          SOUND_BASE_A, SOUND_BASE_Bb, SOUND_BASE_B, SOUND_BASE_C, SOUND_BASE_Db, SOUND_BASE_D,
          SOUND_BASE_Eb, SOUND_BASE_E, SOUND_BASE_F, SOUND_BASE_Gb, SOUND_BASE_G, SOUND_BASE_Ab
        ].freeze
        newSoundNames = []
        rootIndex = soundNames.index(rootSound)

        currentRootIndex = rootIndex
        for _ in 0...soundNames.count do
          currentRootIndex = currentRootIndex == soundNames.count ? 0 : currentRootIndex
          newSoundNames.push(soundNames[currentRootIndex])
          currentRootIndex += 1
        end
        return newSoundNames
      end

      def self.tunePureBase(tuningInfo, centOffsets) 
        tuning = {}
        soundNames = self.arrangeSoundNamesForRootSound(tuningInfo.rootSound)

        # Based on equal tuning
        tuningEqualBase = self.tuneEqualBase(tuningInfo.pitch, tuningInfo.transpositionNote)

        for i in 0...soundNames.count do
          sound = soundNames[i]
          frequencyForEqual = tuningEqualBase[sound]
          frequency = frequencyForEqual * (2.0 ** centOffsets[i])
          tuning[sound] = frequency
        end

        return tuning
      end

      def self.tunePureMajorByInfo(tuningInfo)
        centOffsetsPureMajor = self.centOffsetsForPureMajor()
        tuningPureMajorBase = self.tunePureBase(tuningInfo, centOffsetsPureMajor)
        tuning = self.tuneWholeTuningPure(tuningPureMajorBase)
        return tuning
      end

      def self.tunePureMinorByInfo(tuningInfo)
        centOffsetsPureMinor = self.centOffsetsForPureMinor()
        tuningPureMinorBase = self.tunePureBase(tuningInfo, centOffsetsPureMinor)
        tuning = self.tuneWholeTuningPure(tuningPureMinorBase)
        return tuning
      end

      # Generates for multiple octaves 
      def self.tuneWholeTuningPure(tuningPureBase)
        tuning = {}
        for octave in 1...DEFAULT_MAX_OCTAVE do
          tuningForCurrentOctave = self.tuneForOctave(octave, tuningPureBase)
          for (soundName, frequency) in tuningForCurrentOctave do
            tuning[soundName] = frequency
          end
        end
        return tuning
      end
    end
  end
end
