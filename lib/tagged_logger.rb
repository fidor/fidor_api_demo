class TaggedLogger
  def initialize(tag, logger)
    @tag    = tag
    @logger = logger
  end

  delegate :formatter, to: :@logger

  def debug(text = nil, &block)
    write(:debug, text, &block)
  end

  def info(text = nil, &block)
    write(:info, text, &block)
  end

  def warn(text = nil, &block)
    write(:warn, text, &block)
  end

  def error(text = nil, &block)
    write(:error, text, &block)
  end

  def fatal(text = nil, &block)
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
    @logger.public_send(level, "[#{@tag}] #{text}")
  end
end
