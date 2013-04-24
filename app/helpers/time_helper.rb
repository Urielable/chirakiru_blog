module TimeHelper
  Date.class_eval do # es como si fuera inline
    def pretty
      months = {
        1 => 'enero',
        2 => 'febrero',
        3 => 'marzo',
        4 => 'abril',
        5 => 'mayo',
        6 => 'junio',
        7 => 'julio',
        8 => 'agosto',
        9 => 'septiembre',
        10 => 'octubre',
        11 => 'noviembre',
        12 => 'diciembre'
      }
      "#{months[self.month]} #{self.day}"
    end
  end
end
