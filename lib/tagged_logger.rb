class TaggedLogger
  def initialize(tag, logger)
    @tag    = tag
    @logger = logger
  end

  def debug(text, &block)
    write(:debug, text, &block)
  end

  def info(text, &block)
    write(:info, text, &block)
  end

  def warn(text, &block)
    write(:warn, text, &block)
  end

  def error(text, &block)
    write(:error, text, &block)
  end

  def fatal(text, &block)
    write(:fatal, text, &block)
  end

  private

  def write(level, text, &block)
    if text && block
      log(level, "#{text}: #{block.call}")
    elsif block
      log(level, block.call)
    else
      log(level, text)
    end
  end

  def log(level, text)
    @logger.tagged(@tag) { @logger.public_send(level, text) }
  end
end
