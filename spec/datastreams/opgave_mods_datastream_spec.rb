# spec/datastreams/opgave_mods_datastream_spec.rb
require 'spec_helper'

describe OpgaveModsDatastream do
  
  before(:each) do
    @mods = fixture("eksempel_opgave.mods.xml")
    @ds = OpgaveModsDatastream.from_xml(@mods)
  end

  it "should expose bibliographic info for en opgave" do
    @ds.title.should == ["The Cambridge history of nineteenth-century political thought"]
    @ds.undertitel.should == ["Undertitel"]
    @ds.get_authors.should == [{"gn"=>"Gareth Stedman", "sn"=>"Jones"}, {"gn"=>"Anders", "sn"=>"And"}]
    @ds.abstract.should == ["This major work of academic reference provides the first comprehensive survey of political thought in Europe, North America and Asia in the century following the French Revolution. Written by a distinguished team of international scholars, this Cambridge History is the latest in a sequence of volumes firmly established as the principal reference source for the history of political thought. In a series of scholarly but accessible essays, every major theme in nineteenth-century political thought is covered, including political economy, religion, democratic radicalism, nationalism, socialism and feminism. The volume also includes studies of major figures, including Hegel, Mill, Bentham and Marx, and biographical notes on every significant thinker in the period. Of interest to students and scholars of politics and history at all levels, this volume explores seismic changes in the languages and expectations of politics accompanying political revolution, industrialisation and imperial expansion and less-noted continuities in political and social thinking\"--\n\"This major work of academic reference provides the first comprehensive survey of political thought in Europe, North America and Asia in the century following the French Revolution. Written by a distinguished team of international scholars, this Cambridge History is the latest in a sequence of volumes firmly established as the principal reference source for the history of political thought. In a series of scholarly but accessible essays, every major theme in nineteenth-century political thought is covered, including political economy, religion, democratic radicalism, nationalism, socialism and feminism. The volume also includes studies of major figures, including Hegel, Mill, Bentham and Marx and biographical notes on every significant thinker in the period. Of interest to students and scholars of politics and history at all levels, this volume explores seismic changes in the languages and expectations of politics accompanying political revolution, industrialisation and imperial expansion and less-noted continuities in political and social thinking"]
    @ds.afleveringsaar.should == ["2011"]
    @ds.studium.should == ["Politologi"]
  end


  it "should expose titles for en opgave" do
    @ds.title.should == ["The Cambridge history of nineteenth-century political thought"]
    @ds.undertitel.should == ["Undertitel"]
  end

  it "should expose forfatter for en opgave" do
    @ds.get_authors.should == [{"gn"=>"Gareth Stedman", "sn"=>"Jones"}, {"gn"=>"Anders", "sn"=>"And"}]
  end

  it "should expose studium for en opgave" do
    @ds.studium.should == ["Politologi"]
  end

  it "should expose afleveringsaar for en opgave" do
    @ds.afleveringsaar.should == ["2011"]
  end

  it "should expose abstract for en opgave" do
    @ds.abstract.should == ["This major work of academic reference provides the first comprehensive survey of political thought in Europe, North America and Asia in the century following the French Revolution. Written by a distinguished team of international scholars, this Cambridge History is the latest in a sequence of volumes firmly established as the principal reference source for the history of political thought. In a series of scholarly but accessible essays, every major theme in nineteenth-century political thought is covered, including political economy, religion, democratic radicalism, nationalism, socialism and feminism. The volume also includes studies of major figures, including Hegel, Mill, Bentham and Marx, and biographical notes on every significant thinker in the period. Of interest to students and scholars of politics and history at all levels, this volume explores seismic changes in the languages and expectations of politics accompanying political revolution, industrialisation and imperial expansion and less-noted continuities in political and social thinking\"--\n\"This major work of academic reference provides the first comprehensive survey of political thought in Europe, North America and Asia in the century following the French Revolution. Written by a distinguished team of international scholars, this Cambridge History is the latest in a sequence of volumes firmly established as the principal reference source for the history of political thought. In a series of scholarly but accessible essays, every major theme in nineteenth-century political thought is covered, including political economy, religion, democratic radicalism, nationalism, socialism and feminism. The volume also includes studies of major figures, including Hegel, Mill, Bentham and Marx and biographical notes on every significant thinker in the period. Of interest to students and scholars of politics and history at all levels, this volume explores seismic changes in the languages and expectations of politics accompanying political revolution, industrialisation and imperial expansion and less-noted continuities in political and social thinking"]
  end

end
