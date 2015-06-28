module Audio
  class OctaveRange
    def initialize(first, last)
      @first = first
      @last  = last
    end
    attr_accessor :first, :last
  end
end
