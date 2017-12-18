--- pigfile.txt is text data with lower case words

REGISTER /home/hduser1/Downloads/udfpig.jar;

DEFINE ConvertLowerToUpper myudfs.UPPEER();

bag1 = load '/home/hduser1/Downloads/pigfile.txt using PigStorage() as (name:chararray);

bag2= foreach bag1 generate ConvertLowerToUpper(name);

dump bag2;


