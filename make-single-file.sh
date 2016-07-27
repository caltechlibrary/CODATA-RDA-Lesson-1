#!/bin/bash

if [ -f "build-page.bash" ]; then
    /bin/rm build-page.bash
fi
if [ -f "lesson.md" ]; then
    /bin/rm lesson.md
fi
echo "#!/bin/bash" > build-page.bash
cat layout.md | while read FNAME; do
    if [ -f "$FNAME" ]; then
        if [ "${FNAME:(-3)}" = ".md" ]; then
            echo "cat ./\"$FNAME\" >> lesson.md " >> build-page.bash
        else
            echo "echo \"<a href='$FNAME'>$FNAME</a>\" >> lesson.md" >> build-page.bash
        fi
    fi
done

if [ -f "build-page.bash" ]; then
    bash build-page.bash
fi
