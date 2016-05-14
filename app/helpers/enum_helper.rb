module EnumHelper

  def t_enum(inst, enum)
    value = inst.send(enum);
    t_enum_class(inst.class, enum, value)
  end

  def t_enum_class(klass, enum, value)
    unless value.blank?
      I18n.t("activerecord.enums.#{klass.to_s.demodulize.underscore}.#{enum}.#{value}")
    end
  end

end
