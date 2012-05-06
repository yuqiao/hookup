# -*- encoding: utf-8 -*-
require File.expand_path("../spec_helper", __FILE__)
require 'fileutils'

describe Backchat::WebSocket::FileBuffer do 
  
  context "when opening" do
    work_path = "./rb-test-work"
    log_path = "./rb-test-work/testing/and/such/buffer.log"

    before(:each) do 
      FileUtils.rm_rf(work_path) if File.exist?(work_path)
    end

    it "creates the path if missing" do
      buff = FileBuffer.new(work_path)
      buff.open
      File.exist?(work_path).should be_true
      FileUtils.rm_rf(work_path)
    end
  end

  context 'when not draining' do
    work_path = "./test-work2"
    log_path = "#{work_path}/buffer.log"
    exp1 = "the first message"
    exp2 = "the second message"

    it "writes to a file" do
      FileUtils.rm_rf(work_path) if File.exist?(work_path)
      buff = FileBuffer.new(log_path)
      lines = []
      buff.on(:open) do         
        buff.write(exp1)
        buff.write(exp2) do
          buff.close
        end
      end
      buff.on(:close) do 
        lines = File.open(log_path).readlines
        FileUtils.rm_rf(work_path)
      end
      buff.open
      lines.size.should == 2
    end
  end 

  context "when draining" do
    it "writes new sends to the memory buffer" do
      
    end

    it "raises data events for every line in the buffer" do
      
    end
  end
end