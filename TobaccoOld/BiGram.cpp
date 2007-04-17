//#define OV_DEBUG

#include <algorithm>
#include <math.h>
#include <limits>

#include "BiGram.h"

#ifndef WIN32
	#include <OpenVanilla/OVUtility.h>
#else
	#include "OVUtility.h"
#endif

BiGram::BiGram()
{
}

BiGram::~BiGram()
{
}

int BiGram::maximumMatching(
    DictionarySingleton* dictionary, vector<Token>& tokenVectorRef,
    size_t index, size_t stop, bool doBackward)
{
	vector<int> boundaryVector;
	vector< vector<Vocabulary> > vectorOfVocabularyVector;
	size_t begin = index;
	size_t end = stop;
	if(doBackward)
	{
		reverse(tokenVectorRef.begin(), tokenVectorRef.end());
		begin = tokenVectorRef.size() - stop;
		end = tokenVectorRef.size() - index;
		index = begin;
		stop = end;
	}

	while(index < stop)
	{
		size_t offsetBound = stop - index;
		if(offsetBound > MAX_CONTEXT_LENGTH)
			offsetBound = MAX_CONTEXT_LENGTH;
		bool foundFlag = false;
		vector<string> initialCharacterStringVector =
            tokenVectorRef[index].characterStringVector;
		vector<string> foundCharacterStringVector;
		size_t currentIndex = index;

		while(!foundFlag)
		{
			size_t bound = 1;
			vector<string> currentCharacterStringVector = 
                initialCharacterStringVector;

			for(size_t offset = 1; offset < offsetBound; ++offset)
			{
				vector<string> newCharacterStringVector;
				currentIndex = index + offset;
				if(doBackward)
				{
					BiGram::getCharacterCombination(
						tokenVectorRef[currentIndex].characterStringVector,
						currentCharacterStringVector,
						newCharacterStringVector);
				}
				else
				{
					BiGram::getCharacterCombination(
						currentCharacterStringVector,
						tokenVectorRef[currentIndex].characterStringVector,
						newCharacterStringVector);
				}
				currentCharacterStringVector = newCharacterStringVector;

				bound = offset + 1;
			}

			for(size_t i = 0; i < currentCharacterStringVector.size(); ++i)
			{
				string tokenSequence = currentCharacterStringVector[i];
				vector<Vocabulary> tempVocabularies;
				if(dictionary->isVocabulary(tokenSequence))
				{
					foundFlag = true;
					foundCharacterStringVector.push_back(tokenSequence);
				}
			}

			if(foundFlag)
			{
				if(bound < MAX_CONTEXT_LENGTH)
				{
					for(size_t round = 0; round < bound; ++round)
					{
						size_t tokenIndex = currentIndex - round;
						if(round == bound - 1)
						{
							if(doBackward)
								tokenVectorRef[tokenIndex].withSuffix = false;
							else
								tokenVectorRef[tokenIndex].withPrefix = false;
						}
						else
						{
							if(doBackward)
								tokenVectorRef[tokenIndex].withSuffix = true;
							else
								tokenVectorRef[tokenIndex].withPrefix = true;
						}

						if(round == 0)
						{
							if(doBackward)
								tokenVectorRef[tokenIndex].withPrefix = false;
							else
								tokenVectorRef[tokenIndex].withSuffix = false;
						}
						else
						{
							if(doBackward)
								tokenVectorRef[tokenIndex].withPrefix = true;
							else
								tokenVectorRef[tokenIndex].withSuffix = true;
						}
					}
				}

				break;
			}
			else
			{
				--currentIndex;
				--offsetBound;

				if(offsetBound < 0 || currentIndex < 0)
				{
					if(doBackward)
						reverse(tokenVectorRef.begin(), tokenVectorRef.end());

					return 0;
				}
			}
		}

		vector<Vocabulary> currentVocabularyVector;
		for(size_t j = 0; j < foundCharacterStringVector.size(); ++j)
		{
			string tokenSequence = foundCharacterStringVector[j];
			vector<Vocabulary> vocabularies;
			dictionary->getWordsByCharacters(
			    tokenSequence, vocabularies, true);

            for(size_t k = 0; k < vocabularies.size(); k++)
				currentVocabularyVector.push_back(vocabularies[k]);
		}

		size_t threshold = 0;
		if(currentVocabularyVector[0].freq > 199) {
			for(size_t step = 0; step < currentVocabularyVector.size(); step++)
			{
				if(currentVocabularyVector[step].freq < 200) {
					threshold = step;
					break;
				}
			}
		}	
		if(threshold > 0)
			currentVocabularyVector.erase(
				currentVocabularyVector.begin() + threshold,
				currentVocabularyVector.end());

		vectorOfVocabularyVector.push_back(currentVocabularyVector);

		index = currentIndex + 1;
	}

	vector<Vocabulary> combinedVocabularyVector = vectorOfVocabularyVector[0];
	for(size_t step = 1; step < vectorOfVocabularyVector.size(); ++step)
	{
		vector<Vocabulary> rightVocabularyVector =
            vectorOfVocabularyVector[step];

        vector<Vocabulary> leftVocabularyVector =
		  combinedVocabularyVector;
		if(doBackward)
            BiGram::getVocabularyCombination(
                rightVocabularyVector, leftVocabularyVector,
				combinedVocabularyVector);
		else
			BiGram::getVocabularyCombination(
				leftVocabularyVector, rightVocabularyVector,
				combinedVocabularyVector);
	}

	Vocabulary bestVocabularyCombination = combinedVocabularyVector.front();

	size_t from = begin;
	size_t to = end;
	if(doBackward)
	{
		reverse(tokenVectorRef.begin(), tokenVectorRef.end());
		to = tokenVectorRef.size() - begin;
		from = tokenVectorRef.size() - end;
	}
	size_t shift = 0;
	for(size_t pos = from; pos < to; ++pos)
	{
		tokenVectorRef[pos].word =
            bestVocabularyCombination.word.substr(shift, 3);
            
        shift += 3;
        /// It is BAD, really BAD... for UTF-8 Chinese only.
    }

	return bestVocabularyCombination.freq;
}

void BiGram::getCharacterCombination(
    vector<string>& leftRef, vector<string>& rightRef,
    vector<string>& combinedRef)
{
	for(size_t i = 0; i < leftRef.size(); ++i)
		for(size_t j = 0; j < rightRef.size(); ++j)
			combinedRef.push_back(leftRef[i] + "\t" + rightRef[j]);
}

void BiGram::getVocabularyCombination(
    vector<Vocabulary>& leftRef, vector<Vocabulary>& rightRef,
    vector<Vocabulary>& combinedRef)
{
    vector<Vocabulary> combinedVocabularyVector;
	size_t leftBound = leftRef.size();
	if(leftBound > N_BEST)
		leftBound = N_BEST;
	size_t rightBound = rightRef.size();
	if(rightBound > N_BEST)
		rightBound = N_BEST;

	for(size_t i = 0; i < leftBound; ++i)
	{
		for(size_t j = 0; j < rightBound; ++j)
		{
			Vocabulary combinedVocabulary;
			combinedVocabulary.word = leftRef[i].word + rightRef[j].word;

			int leftFreq = leftRef[i].freq;
			int rightFreq = rightRef[j].freq;
			int matrix = leftFreq + rightFreq;
			
			double score = 0.0;
			if(matrix > 0) {
				combinedVocabulary.freq = matrix;
				score = matrix;			
			} else {
				combinedVocabulary.freq = 1;
				score = numeric_limits<double>::min();
			}
				
			combinedVocabulary.prob =
				-(log(score/numeric_limits<double>::max()) / log(2.0));
			combinedVocabularyVector.push_back(combinedVocabulary);
		}
	}
	
	sort(
		combinedVocabularyVector.begin(),
		combinedVocabularyVector.end(),
		Vocabulary::isProbGreater);

	combinedRef = combinedVocabularyVector;
}
