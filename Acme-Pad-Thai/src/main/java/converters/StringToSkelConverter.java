package converters;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import repositories.SkelRepository;
import domain.Skel;

@Component
@Transactional

// TODO Replace Skel in this converter

public class StringToSkelConverter implements Converter<String, Skel>{

	@Autowired
	SkelRepository skelRepository;
	
	@Override
	public Skel convert(String text) {
		Skel res;
		int id;
		
		try {
			if(StringUtils.isEmpty(text))
				res = null;
			else {
				id = Integer.valueOf(text);
				res = skelRepository.findOne(id);
			}
		} catch (Throwable th) {
			throw new IllegalArgumentException(th);
		}
		
		return res;
	}
}
