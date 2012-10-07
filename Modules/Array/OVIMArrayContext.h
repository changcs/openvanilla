//
// OVIMArrayContext.h
//
// Copyright (c) 2004-2012 Lukhnos Liu (lukhnos at openvanilla dot org)
//
// Permission is hereby granted, free of charge, to any person
// obtaining a copy of this software and associated documentation
// files (the "Software"), to deal in the Software without
// restriction, including without limitation the rights to use,
// copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the
// Software is furnished to do so, subject to the following
// conditions:
//
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
// OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
// HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
// WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
// OTHER DEALINGS IN THE SOFTWARE.
//

#ifndef OVIMArrayContext_h
#define OVIMArrayContext_h

#include "OpenVanilla.h"
#include "OVIMArrayKeySequence.h"

namespace OpenVanilla {
    using namespace std;

    class OVIMArray;
    
    class OVIMArrayContext : public OVEventHandlingContext {
    public:  
        OVIMArrayContext(OVIMArray* module);
        virtual void startSession(OVLoaderService* loaderService);
        virtual bool handleKey(OVKey* key, OVTextBuffer* readingText, OVTextBuffer* composingText, OVCandidateService* candidateService, OVLoaderService* loaderService);

    protected:
        enum STATE {
            STATE_WAIT_KEY1 = 0,
            STATE_WAIT_KEY2,
            STATE_WAIT_KEY3,
            STATE_WAIT_CANDIDATE
        };

        const int RET_PASS = 0;
        const int RET_DONE = 1;
        const int RET_CONTINUE = 2;

        void changeState(STATE s);
        void changeBackState(STATE s);

        bool isWSeq(char a, char b) const;
        bool isForceSPSeq();

        void clear();
        void clearAll(OVTextBuffer* buf, OVCandidateService* candi_bar);
        void clearCandidate(OVCandidateService *candi_bar);

        void updateDisplay(OVTextBuffer*);
        int updateCandidate(OVCINDataTable *tab,OVTextBuffer *buf, OVCandidateService *candibar, OVLoaderService *loaderService);
        
        void sendAndReset(const char *, OVTextBuffer* , OVCandidateService* , OVLoaderService* );
        void queryKeyName(const char *keys, std::string& outKeyNames);

        int keyEvent(OVKey* , OVTextBuffer* , OVCandidateService* , OVLoaderService* );
        void dispatchStateHandler(OVKey* , OVTextBuffer* , OVCandidateService* , OVLoaderService* );
        int WaitKey1(OVKey* , OVTextBuffer* , OVCandidateService* , OVLoaderService* );
        int WaitKey2(OVKey* , OVTextBuffer* , OVCandidateService* , OVLoaderService* );
        int WaitKey3(OVKey* , OVTextBuffer* , OVCandidateService* , OVLoaderService* );
        int WaitCandidate(OVKey* , OVTextBuffer* , OVCandidateService* , OVLoaderService* );

        OVIMArray* parent;
        OVIMArrayKeySequence keyseq;
        STATE state;
        vector<string> candidateStringVector;
    };
};

#endif